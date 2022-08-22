//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Paul Kenjerski on 8/20/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var tries = 0
    @State private var buttonName = "Continue"

    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            score += 1
            tries += 1
            scoreTitle = "Correct"
            buttonName = "Continue"

        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
            buttonName = "Continue"
            tries += 1
        }
    
        if score == 10 {
            scoreTitle = "\(score) / \(tries) Amazing job!"
            score = 0
            tries = 0
            buttonName = "Play Again ?"
        }
        
        showingScore = true
    
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    
    

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.3, green: 0.4, blue: 0.45), location: 0.1),
                .init(color: Color(red: 0, green: 0, blue: 0), location: 1.2),
            ], center: .top, startRadius: 200, endRadius: 500)
                .ignoresSafeArea()
            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.weight(.semibold))
            
            
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.bold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                           flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                                .shadow(radius: 6)
                                .padding(5)
                        }
                    }
                }
                .padding(30)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
        }
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button(buttonName, action: askQuestion)
        } //message: {
           // Text("Your score is \(score)")
        //}
    }
        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
