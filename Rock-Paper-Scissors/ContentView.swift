//
//  ContentView.swift
//  Rock-Paper-Scissors
//
//  Created by Saverio Negro on 26/10/24.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["rock", "paper", "scissors"]
    @State private var computerMove = ["rock", "paper", "scissors"].randomElement()!
    @State private var playerMove: String = "rock"
    @State private var shouldWin: Bool = Bool.random()
    @State private var points = 0
    @State private var isShowingScoreAlert = false
    @State private var isShowingResultAlert = false
    @State private var match = 1
    
    func didPlayerWin() -> Bool {
        switch (computerMove, playerMove) {
        case ("rock", "paper"):
            true
        case ("rock", "scissors"):
            false
        case ("paper", "scissors"):
            true
        case ("paper", "rock"):
            false
        case ("scissors", "rock"):
            true
        case ("scissors", "paper"):
            false
        default:
            false
        }
    }
    
    func didPlayerLose() -> Bool {
        switch (computerMove, playerMove) {
        case ("rock", "paper"):
            false
        case ("rock", "scissors"):
            true
        case ("paper", "scissors"):
            false
        case ("paper", "rock"):
            true
        case ("scissors", "rock"):
            false
        case ("scissors", "paper"):
            true
        default:
            false
        }
    }
    
    func processScore() {
        if shouldWin && didPlayerWin() {
            points += 1
        } else if !shouldWin && didPlayerLose() {
            points += 1
        } else if !didPlayerWin() && !didPlayerLose() {
            points += 0
        } else {
            points -= 1
        }
        isShowingScoreAlert = true
    }
    
    func nextMatch() {
        if match == 10 {
            isShowingResultAlert = true
            return
        }
        
        computerMove = moves.randomElement()!
        shouldWin.toggle()
        playerMove = "rock"
        match += 1
    }
    
    func reset() {
        points = 0
        match = 1
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.16, green: 0.50, blue: 0.73)
                .ignoresSafeArea()
            VStack {
                Text("Battle to \(shouldWin ? "Win" : "Lose")")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                Text("Match \(match)/10")
                    .foregroundStyle(.white)
                Spacer()
                Text("CPU Move")
                    .font(.title2)
                    .foregroundStyle(.white)
                Image(computerMove)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                Text("Your move")
                    .font(.title2)
                    .foregroundStyle(.white)
                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button {
                            playerMove = move
                        } label: {
                            Image(move)
                                .resizable()
                                .scaledToFit()
                                .opacity(move == playerMove ? 1.0 : 0.5)
                        }
                    }
                }
                
                Button {
                    processScore()
                } label: {
                    Text("Choose")
                        .padding()
                        .font(.title2)
                        .foregroundStyle(.white)
                        .background(.indigo)
                        .clipShape(.buttonBorder)
                }
            }
            .padding()
        }
        .alert("Current Score", isPresented: $isShowingScoreAlert) {
            Button("OKAY", role: .destructive) {
                nextMatch()
            }
        } message: {
            Text("Your current score is \(points)")
        }
        .alert("Result", isPresented: $isShowingResultAlert) {
            Button("RESTART", role: .destructive) {
                reset()
            }
        } message: {
            Text("Your total score is \(points)")
        }
    }
}

#Preview {
    ContentView()
}
