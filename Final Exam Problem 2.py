class ClassExample:
    def __init__(self):
        self.example = 0
    def print_input(self):
        text = self.example
        print(text.upper())

exampleobjectone1 = ClassExample()
exampleobjectone1.example=input()
exampleobjectone1.print_input()
