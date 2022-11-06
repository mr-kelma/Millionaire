//
//  GameBrain.swift
//  Millionaire
//
//  Created by Valery Keplin on 4.11.22.
//

import Foundation

class GameBrain {
    
    //MARK: - Properties
    var questions = Question.questions
    var numberOfQuestion = 0
    var numberOfQuestionText: String?
    var currentQuestion: String?
    var currentAnswerA: String?
    var currentAnswerB: String?
    var currentAnswerC: String?
    var currentAnswerD: String?
    var currentAnswerCA: String?
    
    //MARK: - Logic
    
    func getQuestion() {
        currentQuestion = questions[numberOfQuestion].text
        numberOfQuestionText = questions[numberOfQuestion].number
        currentAnswerA = questions[numberOfQuestion].answer[0]
        currentAnswerB = questions[numberOfQuestion].answer[1]
        currentAnswerC = questions[numberOfQuestion].answer[2]
        currentAnswerD = questions[numberOfQuestion].answer[3]
        currentAnswerCA = questions[numberOfQuestion].correctAnswer
        numberOfQuestion += 1
    }
    
    func checkAnswer(_ userAnswer: String) -> Bool {
        let check = userAnswer == currentAnswerCA
        questions[numberOfQuestion - 1].isAnswered = check
        return check
    }
    
    func wonAmountWhenTachMoney() -> String {
        return questions[numberOfQuestion - 1].number
       }
    
 func wonAmountWhenEndTime() -> String {
        switch numberOfQuestion {
        case 0...5:
            return "\nВы ничего не выиграли 😕"
        case 6...10:
            return "\nВаш выигрыш 1 000 рублей!"
        case 11...15:
            return "\nВаш выигрыш 32 000 рублей!"
        default:
            return ""
        }
    }
}
