#!/usr/bin/env python3
import genesis as gs
import torch

cuda_available = torch.cuda.is_available()
if cuda_available:
    print("CUDA is available - using GPU backend")
    backend = gs.cuda
else:
    print("CUDA not available - falling back to CPU backend")
    backend = gs.cpu

gs.init(backend=backend)

scene = gs.Scene(show_viewer=False)
plane = scene.add_entity(gs.morphs.Plane())
franka = scene.add_entity(
    gs.morphs.MJCF(file='xml/franka_emika_panda/panda.xml'),
)

scene.build()

for i in range(1000):
    scene.step()
