//
//  File.swift
//  
//
//  Created by Alyssa Hanson (Student) on 6/3/24.
//

import Foundation


public extension PrinterController {
    func setFlowRate1(to flowRate1: Double) async throws {
        // TODO: 
        try await with(.pump) {
          try await waveformController?.setRawVoltage(to: flowRate1)
        }
    }

    func setFlowRate2(to flowRate2: Double) async throws {
      try await with(.pump) {
        try await waveformController?.setRawVoltage(to: flowRate1)
      }
    }

    func setInnerDiameter1(to voltage: Double) async throws {
        try await with(.waveform) {
            try await waveformController?.setAmplifiedVoltage(to: voltage)
        }
    }

    func setInnerDiameter2(to offset: Double) async throws {
        try await with(.waveform) {
            try await waveformController?.setAmplifiedVoltageOffset(to: offset)
        }
    }
    
}
