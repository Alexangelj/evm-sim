import random from "random";

class Model {
  public running: boolean;
  public currId: number;
  public readonly schedule: any;
  public random: any;
  public _seed: any;

  init(seed: any): any {
    this._seed = random.rng._seed(seed);
    this.random = random.rng.next();
  }

  constructor() {
    this.running = true;
    this.currId = 0;
  }

  run() {
    while (this.running) {
      this.step();
    }
  }

  step() {}

  get nextId(): number {
    return this.currId++;
  }
}

export default Model;
