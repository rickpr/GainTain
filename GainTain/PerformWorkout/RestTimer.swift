//
//  RestTimer.swift
//  GainTain
//
//  Created by fdisk on 11/23/22.
//

import SwiftUI

struct RestTimer: View {
    @State private var timeEndsAt: TimeInterval? = nil
    @State private var timeRemaining: Double? = nil
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if timeEndsAt != nil {
            stopTimeButton(timeText: prettyTime())
                .onReceive(timer) { _ in
                    if timeEndsAt != nil {
                        timeRemaining = timeEndsAt! - Date().timeIntervalSinceReferenceDate + 1
                        if timeRemaining! <= 0 { timeEndsAt = nil }
                    }
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
        Button(action: {
            timeEndsAt = Date().timeIntervalSinceReferenceDate + Double(timeInSeconds)
            timeRemaining = Double(timeInSeconds)
        }) { FullWidthButton(Text(timeText)) }
    }
    
    private func stopTimeButton(timeText: String) -> some View {
        Button(action: { timeEndsAt = nil }) { FullWidthButton(Text(timeText)) }
    }
    
    private func prettyTime() -> String {
        let timeLeft = Int(timeRemaining ?? 0)
        let minutes = Int(timeLeft / 60)
        var seconds = String(timeLeft % 60)
        if seconds.count < 2 { seconds = "0\(seconds)" }
        return "\(minutes):\(seconds)"
    }
}

struct RestTimer_Previews: PreviewProvider {
    static var previews: some View {
        RestTimer()
    }
}
