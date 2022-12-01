import { describe, it, expect } from 'vitest';

import {
    degenerate, take, sum, pipe,
} from './iterators';

function* numbers(n = 3) {
    let i = 0;

    while (i < n) {
        yield i++;
    }
}

describe('iterators', () => {
    describe('degenerate', () => {
        it('converts a generator to an array', () => {
            expect(degenerate(numbers(3))).toStrictEqual([0, 1, 2]);
        });

        it('converts a generator to a scalar value', () => {
            expect(degenerate(numbers(1))).toStrictEqual(0);
        });
    });

    // describe('take', () => {
    //     it('is a function', () => {
    //         expect(typeof take).toBe('function');
    //     });
    //
    //     it('returns the specified number of elements', () => {
    //         expect([...take(3)([1, 2, 3, 4, 5, 6, 7])]).toStrictEqual([1, 2, 3]);
    //     });
    // });

    describe('sum', () => {
        it('is a function', () => {
            expect(typeof sum).toBe('function');
        });

        it('returns the sum of numbers', () => {
            const result = degenerate(sum([1, 2, 3]));

            expect(result).toBe(6);
        });
    });

    describe('pipe', () => {
        it('is a function', () => {
            expect(typeof pipe).toBe('function');
        });

        it('calls functions in order', () => {
            const result = pipe([sum, degenerate])(numbers(3));

            expect(result).toBe(3);
        });
    });
});
