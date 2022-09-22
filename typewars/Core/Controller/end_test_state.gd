class_name EndTestState
extends State

var menu

func enter() -> void:
    .enter()
    menu = owner.ui_statistics
    menu.visible = true
    print_results()


func print_results() -> void:
    var results = owner.typing_test.results 
    print(results._words)
    print(results.time)
    print(results.wpm)
    print(str("Correct Letters input: ", get_correct_count(results)))


func get_correct_count(_results: TypingTestResults) -> int:
    var correct: int = 0
    for letter in _results._register.keys():
        letter = _results._register[letter]
        if letter.correct_presses:
            correct += letter.correct_presses
    return correct