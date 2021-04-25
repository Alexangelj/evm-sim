import Model from "./model";

class Agent {
  public readonly id: number;
  public readonly model: Model;

  constructor(aid: number, model: Model) {
    this.id = aid;
    this.model = model;
  }

  step() {}

  advance() {}

  get random(): any {
    return this.model.random;
  }
}
