import numpy as np

data = [
    [0.9, 0, 0, 0.1],
    [0, 0.8, 0.1, 0.1],
    [0, 0.1, 0.8, 0.1],
    [0.1, 0.1, 0.1, 0.7]
]
room = [0.25, 0.25, 0.25, 0.25]
result = room

for i in range(50):
    result = np.dot(result, data)
    print(result)
