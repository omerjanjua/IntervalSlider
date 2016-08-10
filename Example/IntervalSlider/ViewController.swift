//
//  ViewController.swift
//  IntervalSlider
//
//  Created by shushutochako on 10/01/2015.
//  Copyright (c) 2015 shushutochako. All rights reserved.
//

import UIKit
import IntervalSlider

class ViewController: UIViewController {
  @IBOutlet weak var sliderView1: UIView!
  @IBOutlet weak var sliderView2: UIView!
  @IBOutlet weak var valueLabel1: UILabel!
  @IBOutlet weak var valueLabel2: UILabel!
  
  private var intervalSlider1: IntervalSlider! {
    didSet {
      self.intervalSlider1.tag = 1
      self.sliderView1.addSubview(self.intervalSlider1)
      self.intervalSlider1.delegate = self
    }
  }
  private var intervalSlider2: IntervalSlider! {
    didSet {
      self.intervalSlider2.tag = 2
      self.sliderView2.addSubview(self.intervalSlider2)
      self.intervalSlider2.delegate = self
    }
  }
  private var data1: [Float] {
    return [0, 100, 200 , 300, 400]
  }
  private var data2: [Float] {
    return [0, 1, 2, 3]
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.intervalSlider1 = IntervalSlider(frame: self.sliderView1.bounds, sources: self.createSources())
    let result = self.createSources2()
    self.intervalSlider2 = IntervalSlider(frame: self.sliderView2.bounds, sources: result.sources, options: result.options)
  }
  
    private func createSources() -> [IntervalSliderSource] {
        // Sample of equally inttervals
        var sources = [IntervalSliderSource]()
        var appearanceValue: Float = 0
        
        for data in self.data1 {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
            label.text = "\(Int(data))"
            label.font = UIFont.systemFontOfSize(CGFloat(12))
            label.textColor = UIColor.redColor()
            label.textAlignment = .Center
            
            let imageView = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.setImage(UIImage(named: "1"), forState: .Normal)
            let source = IntervalSliderSource(validValue: data, appearanceValue: appearanceValue, shield: imageView)
            sources.append(source)
            appearanceValue += 25
        }
        return sources
    }
  
    private func createSources2() -> (sources: [IntervalSliderSource], options: [IntervalSliderOption]) {
        // Sample of irregular inttervals
        var sources = [IntervalSliderSource]()
        var appearanceValue: Float = 0
        let data = self.data2

        
        let imageView = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.setImage(UIImage(named: "1"), forState: .Normal)
        let minSource = IntervalSliderSource(validValue: data[0], appearanceValue: appearanceValue, shield: imageView)
        sources.append(minSource)
        appearanceValue += 15

        
        let imageView2 = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView2.setImage(UIImage(named: "2"), forState: .Normal)
        let shortSource = IntervalSliderSource(validValue: data[1], appearanceValue: appearanceValue, shield: imageView2)
        sources.append(shortSource)
        appearanceValue += 3

        
        let imageView3 = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView3.setImage(UIImage(named: "3"), forState: .Normal)
        let longSource = IntervalSliderSource(validValue: data[2], appearanceValue: appearanceValue, shield: imageView3)
        sources.append(longSource)
        appearanceValue += 15

        
        let imageView4 = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView4.setImage(UIImage(named: "4"), forState: .Normal)
        let maxSource = IntervalSliderSource(validValue: data[3], appearanceValue: appearanceValue, shield: imageView4)
        sources.append(maxSource)
        
        let options: [IntervalSliderOption] = [
            .MaximumValue(appearanceValue),
            .MinimumValue(0),
            .AddMark(true),
            .LabelBottomPadding(1),
            .MinimumTrackTintColor(UIColor.redColor())
        ]
        return (sources, options)
    }
}

extension ViewController: IntervalSliderDelegate {
  func confirmValue(slider: IntervalSlider, validValue: Float) {
    switch slider.tag {
    case 1:
      self.valueLabel1.text = "\(Int(validValue))"
    case 2:
      self.valueLabel2.text = "\(Int(validValue))"
    default:
      break
    }
  }
}

