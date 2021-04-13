//
//  Utils.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//

import UIKit

func warningFeedback() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
}

func successFeedback() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

func selectFeedback() {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
}

