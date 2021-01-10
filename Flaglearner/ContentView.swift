//
//  ContentView.swift
//  Flaglearner
//
//  Created by Mark Zhou on 1/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreDescription = ""
    @State private var streak = 0
    
    var body: some View {
        ZStack {
//            Color.blue.edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer]).font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.primary, lineWidth: 5))
                    }
                }
                Spacer()
                
                
                VStack {
                    Text("Current streak:")
                    Text(String(streak)).font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreDescription), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            streak += 1
            scoreTitle = "Correct"
            scoreDescription = "You now have a streak of \(streak)!"
        } else {
            scoreTitle = "Wrong"
            if streak > 0 {
                scoreDescription = "You lost your streak of \(streak). The answer was flag #\(correctAnswer + 1)."
            } else {
                scoreDescription = "The answer was flag #\(correctAnswer + 1)."
            }
            streak = 0
        }

        showingScore = true
    }
}
