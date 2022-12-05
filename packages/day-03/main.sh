#!/usr/bin/env bash
totalPoints=0
itemsList=(a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

function search_bags() {
    input="$1"

    bag1=${input:0:${#input}/2}
    bag2=${input:${#input}/2}

    while test -n "$bag1"; do
        item=${bag1:0:1}

        if [[ $bag2 == *"$item"* ]]; then
            value=0

            for point in "${itemsList[@]}"; do
                value=$((value + 1))

                if [[ $point == "$item" ]]; then
                    echo "$value";
                    break;
                fi
            done

            break
        fi

        bag1=${bag1:1}
    done
}

# shellcheck disable=SC2013
for item in $(cat ./resources/input.txt); do
    value=$(search_bags "$item");
    totalPoints=$((totalPoints + value));
done

echo "Total Points: $totalPoints";
