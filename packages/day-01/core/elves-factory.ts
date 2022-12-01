import Elv from './elv';

export class ElvesFactory {
    public static create(input: string) {
        const store = {
            index: 0,
            items: [],
        };

        return input.split('\n').reduce((result: Elv[], line: string) => {
            const _line = line.trim();

            if (!_line) {
                const elv = new Elv(store.index, store.items);

                store.items = [];
                store.index++;

                return result.concat(elv);
            }
            store.items.push(parseInt(_line, 10));

            return result;
        }, []);
    }
}
