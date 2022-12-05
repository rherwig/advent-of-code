#!/usr/bin/env kscript
import java.io.File;

val MAX_LINE_LENGTH = 36

fun <T> transpose(table: ArrayList<ArrayList<T>>): ArrayList<ArrayList<T>> {
    val result: ArrayList<ArrayList<T>> = ArrayList()
    val N = table[0].size

    for (i in 0 until N) {
        val col: ArrayList<T> = ArrayList()

        for (row in table) {
            if (row[i] !== ' ') {
                col.add(row[i])
            }
        }

        result.add(col)
    }

    return result
}

fun buildStacks(stackDescription: ArrayList<String>): ArrayList<ArrayList<Char>> {
    var stack = ArrayList<ArrayList<Char>>()

    for (stackRow in stackDescription) {
        val paddedRow = stackRow.padEnd(MAX_LINE_LENGTH, ' ')
        var resultRow = ArrayList<Char>()

        for (i in 1..paddedRow.length step 4) {
            resultRow.add(paddedRow[i])
        }

        stack.add(resultRow)
    }

    return transpose(stack)
}

fun executeMove(
    stacks: ArrayList<ArrayList<Char>>,
    count: Int,
    from: Int,
    to: Int,
    craneCapacity: Int = 1
): ArrayList<ArrayList<Char>> {
    if (count <= 0) {
        return stacks
    }

    val fromStack = stacks[from - 1]
    val toStack = stacks[to - 1]

    var numberOfMovableItems = Math.min(count, craneCapacity)

    for (i in 0..numberOfMovableItems) {
        if (fromStack.size == 0) {
            continue
        }

        val crate = fromStack.removeFirst()
        toStack.add(0, crate)
    }

    return executeMove(stacks, count - numberOfMovableItems, from, to, craneCapacity)
}

fun parseMove(stacks: ArrayList<ArrayList<Char>>, moveString: String, craneCapacity: Int = 1) {
    val moveRegex = Regex("(\\d+).*?(\\d+).*?(\\d+)")
    val (count, from, to) = moveRegex.find(moveString)!!.destructured

    executeMove(stacks, count.toInt(), from.toInt(), to.toInt(), craneCapacity)
}

fun main() {
    val fileName = "./resources/input.txt"
    val stackRegex = Regex("\\[(\\w)\\]")
    val movesRegex = Regex("move.*\\d+")

    var stackDescription = ArrayList<String>()
    var movesDescription = ArrayList<String>()

    File(fileName).forEachLine {
        if (stackRegex.containsMatchIn(it)) {
            stackDescription.add(it)
        } else if (movesRegex.containsMatchIn(it)) {
            movesDescription.add(it)
        }
    }

    var stacks = buildStacks(stackDescription)

    movesDescription.forEach { moveString -> parseMove(stacks, moveString) }

    val result = stacks.map {
        if (it.size > 0) it.first() else ' '
    }.joinToString("")

    println("Task 1: $result")
}

main()
