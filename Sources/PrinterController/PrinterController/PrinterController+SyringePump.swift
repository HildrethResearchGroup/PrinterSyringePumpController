//
//  File.swift
//  
//
//  Created by Alyssa Hanson (Student) on 6/3/24.
//

import Foundation


public extension PrinterController {
  func setFlowRate1(to flowRate1: Double) async throws {
    try await with(.syringePump) {
      try await waveformController?.setRawVoltage(to: flowRate1)
    }
  }
  
    func setFlowRate2(to flowRate2: Double) async throws {
      try await with(.syringePump) {
        try await waveformController?.setRawVoltage(to: flowRate1)
      }
    }
    
    func setAmplifiedVoltage(to voltage: Double) async throws {
        try await with(.waveform) {
            try await waveformController?.setAmplifiedVoltage(to: voltage)
        }
    }
    
    func setAmplifiedVoltageOffset(to offset: Double) async throws {
        try await with(.waveform) {
            try await waveformController?.setAmplifiedVoltageOffset(to: offset)
        }
    }
  
  func setFrequency(to frequency: Double) async throws {
    try await with(.waveform) {
      try await waveformController?.setFrequency(to: frequency)
    }
  }
  
  func setPhase(to phase: Double) async throws {
    try await with(.waveform) {
      try await waveformController?.setPhase(to: phase)
    }
  }
  
  func setWaveFunction(to waveFunction: WaveFunction) async throws {
    try await with(.waveform) {
      try await waveformController?.setWaveFunction(to: waveFunction)
    }
  }
    
    func setImpedance(to impedance: Double) async throws {
        try await with(.waveform) {
            try await waveformController?.setImpedance(to: impedance)
        }
    }
  
  func turnVoltageOn() async throws {
    try await with(.waveform) {
            await setWaveformState(\.voltageIsOn, to: true)
      try await waveformController?.turnVoltageOn()
    }
  }
  
  func turnVoltageOff() async throws {
    try await with(.waveform) {
            await setWaveformState(\.voltageIsOn, to: false)
      try await waveformController?.turnVoltageOff()
    }
  }
}
