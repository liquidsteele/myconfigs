import random

for i in range(5):
    print(random.randint(1, 100))



for j in range(3):
    print(random.choice(["teste", "coisas", "nmgs"]))


class teste:
    def __init__(self):
        self.value = random.random()
        print(f"Random value initialized: {self.value}")


ti = teste()
