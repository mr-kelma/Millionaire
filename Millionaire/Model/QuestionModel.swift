//
//  QuestionModel.swift
//  Millionaire
//
//  Created by Valery Keplin on 31.10.22.
//

import Foundation

struct Question {
    let number: String
    let text: String
    var answer: [String]
    var correctAnswer: String
    var isAnswered: Bool = false
    
    init(n: String, t: String, a: [String], ca: String) {
        number = n
        text = t
        answer = a
        correctAnswer = ca
    }
    
    static let questions = [
        Question(
            n: "100 рублей",
            t: "Способностью к быстрой смене чего славятся хамелеоны?",
            a: ["Цвета","Размера","Пола","Убеждений"],
            ca: "Цвета"),
        Question(
            n: "200 рублей",
            t: "Что сочиняют спецагентам, отправляя их на задание?",
            a: ["Сказку","Былину","Легенду","Притчу"],
            ca: "Легенду"),
        Question(
            n: "300 рублей",
            t: "Как называют человека, воздерживающегося от употребления мяса?",
            a: ["Абстинент","Каннибал","Вегетарианец","Пуританин"],
            ca: "Вегетарианец"),
        Question(
            n: "500 рублей",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "🌟1 000 рублей🌟",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "2 000 рублей",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "4 000 рублей",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "8 000 рублей",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "16 000 рублей",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "🌟32 000 рублей🌟",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "64 000 рублей",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "125 000 рублей",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "250 000 рублей",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "500 000 рублей",
            t: "",
            a: ["1","2","3","4"],
            ca: ""),
        Question(
            n: "⭐️1 000 000 рублей⭐️",
            t: "",
            a: ["1","2","3","4"],
            ca: "")
    ]
}
