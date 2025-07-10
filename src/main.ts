import { Engine, Scene, FreeCamera, Vector3, HemisphericLight, MeshBuilder } from "@babylonjs/core";

const canvas = document.getElementById("renderCanvas") as HTMLCanvasElement;
const engine = new Engine(canvas, true);

const createScene = () => {
    const scene = new Scene(engine);

    const camera = new FreeCamera("camera1", new Vector3(0, 5, -10), scene);
    camera.setTarget(Vector3.Zero());
    camera.attachControl(canvas, true);

    new HemisphericLight("light", new Vector3(0, 1, 0), scene);

    MeshBuilder.CreateSphere("sphere", {diameter: 2, segments: 32}, scene);
    MeshBuilder.CreateGround("ground", {width: 6, height: 6}, scene);

    return scene;
};

const scene = createScene();

engine.runRenderLoop(() => {
    scene.render();
});

window.addEventListener("resize", () => {
    engine.resize();
});