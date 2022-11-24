//
//  RestTimer.swift
//  GainTain
//
//  Created by fdisk on 11/23/22.
//

import SwiftUI

struct RestTimer: View {
    @State var timeRemaining = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if timeRemaining > 0 {
            timeButton(timeText: prettyTime(), timeInSeconds: 0)
                .onReceive(timer) { _ in
                    timeRemaining -= 1
                }
        } else {
            HStack {
                timeButton(timeText: "1:00", timeInSeconds: 60)
                timeButton(timeText: "2:00", timeInSeconds: 120)
                timeButton(timeText: "3:00", timeInSeconds: 180)
                timeButton(timeText: "4:00", timeInSeconds: 240)
            }
        }
    }
    
    private func timeButton(timeText: String, timeInSeconds: Int) -> some View {
        Button(action: { self.timeRemaining = timeInSeconds }) {
            Text(timeText)
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16))
                .padding()
        }
    }
    
    private func prettyTime() -> String {
        let minutes = Int(timeRemaining / 60)
        var seconds = String(timeRemaining % 60)
        if seconds.count < 2 { seconds = "0\(seconds)" }
        return "\(minutes):\(seconds)"
    }
}

struct RestTimer_Previews: PreviewProvider {
    static var previews: some View {
        RestTimer()
    }
}
