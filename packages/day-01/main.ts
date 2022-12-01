import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';

import {
    take, select, sum, degenerate, pipe,
} from '@hrwg/utils';

import Elv from './core/elv';
import { ElvesFactory } from './core/elves-factory';

function sortElvesByCalories(elves: Elv[]): Elv[] {
    return elves.sort((a, b) => b.totalCalories - a.totalCalories);
}

(() => {
    const input = readFileSync(resolve(__dirname, 'resources/input.txt'), 'utf-8');
    const elves = ElvesFactory.create(input);
    const elvesRanking = sortElvesByCalories(elves);

    function taskOne(): void {
        const winningElv = elvesRanking[0];

        console.log(`The elv with the highest total calories is Elv #${winningElv.index} with ${winningElv.totalCalories} calories.`);
    }

    function taskTwo(): void {
        const r = pipe([
            take(3),
            select('totalCalories'),
            sum,
            degenerate,
        ])(elvesRanking);

        console.log(`The top three elves carry ${r} calories.`);
    }

    taskOne();
    taskTwo();
})();
