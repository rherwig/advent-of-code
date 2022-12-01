export function degenerate<T = any>(generator: Generator<T>): T | T[] {
    const result = [...generator];

    return result.length > 1 ? result : result[0];
}

export const take = (n: number) => function* (elements: Generator<any> | any[]): Generator {
    let i = 0;

    for (const element of elements) {
        if (i >= n) {
            return;
        }

        yield element;
        i++;
    }
};

export function* sum(generator: Generator<number> | number[]): Generator<number> {
    let result = 0;

    for (const element of generator) {
        result += element;
    }

    yield result;
}

export const select = (key: string) => function* (generator: Generator<number> | number[]) {
    for (const element of generator) {
        yield element[key];
    }
};

// eslint-disable-next-line no-unused-vars
export const pipe = (fns: Array<(Generator) => any>) => function (value: Generator<any>) {
    return fns.reduce((result, fn) => {
        return fn(result);
    }, value);
};
