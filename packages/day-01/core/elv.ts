export default class Elv {
    public index = 0;

    public items: number[];

    constructor(index: number, items: number[]) {
        this.index = index;
        this.items = items;
    }

    get totalCalories() {
        return this.items.reduce((sum, item) => sum + item, 0);
    }
}
