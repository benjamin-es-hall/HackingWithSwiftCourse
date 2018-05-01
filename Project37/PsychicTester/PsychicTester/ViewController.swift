//
//  ViewController.swift
//  PsychicTester
//
//  Created by Ben Hall on 30/04/2018.
//  Copyright © 2018 BeshBashBosh. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    // MARK: - Instance properties
    var allCards = [CardViewController]()
    
    // MARK: - Outlets
    @IBOutlet var cardContainer: UIView!
    @IBOutlet var gradientView: GradientView!
    
    // MARK: -  Instance methods
    func cardTapped(_ tapped: CardViewController) {
        // If the view is user interactable continue, if not exit
        guard view.isUserInteractionEnabled == true else { return }
        // Set user interaction of the view to false so that only one card can be tapped until view
        // interaction is re-enabled (in loadCards)
        view.isUserInteractionEnabled = false
        
        // Loop through each card shown on screen
        for card in allCards {
            // Find the card that was tapped
            if card == tapped {
                card.wasTapped() // perform animation
                card.perform(#selector(card.wasntTapped), with: nil, afterDelay: 1) // perform delayed animation
            } else {
                card.wasntTapped() // perform animation
            }
        }
        // After delay reload the cards
        perform(#selector(self.loadCards), with: nil, afterDelay: 2)
    }
    
    // Removes any existing cards from this VC
    private func removeCards() {
        for card in allCards {
            card.view.removeFromSuperview() // remove from the superview ( cardContainer <UIView> )
            card.removeFromParentViewController() // remove reference to parent VC (self)
        }
        
        allCards.removeAll(keepingCapacity: true) // remove any CardViewControllers from the allCards property
        
    }
    
    // Adds Cards to UIView container of this VC
    private func addCard(with image: UIImage, at position: CGPoint, correctCard: UIImage) {

        // 1. Creat new card
        let card = CardViewController()
        // 1a. Set delegate for new CardViewController() to this VC for communication
        card.delegate = self
        
        // 2. View controller containment methods that adds the card's view to the cardContainer UIView
        addChildViewController(card) // Adds CardVC as a child of self
        cardContainer.addSubview(card.view) // Adds CardVC.view as subview to our UIView container
        card.didMove(toParentViewController: self) // Registers the movement (i.e. rotation etc.) to the motion of the parent VC, that is keeps them in sync!
        
        // 3. Position card appropriately and set it's front card image
        card.view.center = position
        card.front.image = image
        
        // 4. Note which card is the star for cheating ;)
        if card.front.image == correctCard {
            card.isCorrect = true
        }
        
        // 5. Add new CardVC to self array of CardVCs
        allCards.append(card)
    }
    
    // Creates particle effects!!
    func createParticles() {
        // Since this isn't SceneKit, but rather UIKit, SKEmitterNode is not available.
        // Instead we use a subclass of CoreAnimation, CAEmitterLayer
        let particleEmitter = CAEmitterLayer()
        
        particleEmitter.emitterPosition = CGPoint(x: view.frame.width / 2.0, y: -50) // set position
        particleEmitter.emitterShape = kCAEmitterLayerLine // set type of emitter
        particleEmitter.emitterSize = CGSize(width: view.frame.width, height: 1) // set size of emitter
        particleEmitter.renderMode = kCAEmitterLayerAdditive // set particles to be additive (layered particles brighter)
        
        // Create the emitter cell
        let cell = CAEmitterCell()
        // Set the emitters properties
        cell.birthRate = 2 // how often particles emitted
        cell.lifetime = 5.0 // how long the particles last once emitted
        cell.velocity = 100 // how fast the particles are emitted
        cell.velocityRange = 50 // the variation on the particle emission velocity
        cell.emissionLongitude = .pi // the angle at which the particles are emitted
        cell.spinRange = 5 // the variation in the spin of emitted particle
        cell.scale = 0.5 // how much the particle scales by
        cell.scaleRange = 0.25 // the variation in the particle's scale amount
        cell.color = UIColor(white: 1, alpha: 0.1).cgColor // the color of emitted particle
        cell.alphaSpeed = -0.025 // the speed at which the alpha level changes
        cell.contents = UIImage(named: "particle")?.cgImage // the actual look of the particle
        particleEmitter.emitterCells = [cell] // add this particle to the particle emitter
        
        // Add the particle emitter as a sublayer to the gradientView (stars will stay behind view in foreground of gradientLayer)
        gradientView.layer.addSublayer(particleEmitter)
    }
    
    // MARK: - objc methods
    @objc func loadCards() {
        // Make the view user interactable
        view.isUserInteractionEnabled = true
        
        // Remove any existing cards
        self.removeCards()
        
        // Set the positions of the cards
        let cardPositions = [
            CGPoint(x: 75, y: 85),
            CGPoint(x: 185, y: 85),
            CGPoint(x: 295, y: 85),
            CGPoint(x: 405, y: 85),
            CGPoint(x: 75, y: 235),
            CGPoint(x: 185, y: 235),
            CGPoint(x: 295, y: 235),
            CGPoint(x: 405, y: 235)
        ]
        
        // Load the front image of the Zener cards
        let circle = UIImage(named: "cardCircle")!
        let cross = UIImage(named: "cardCross")!
        let lines = UIImage(named: "cardLines")!
        let square = UIImage(named: "cardSquare")!
        let star = UIImage(named: "cardStar")!
        
        // create an array of these images to be shuffled
        var images = [circle, circle, cross, cross, lines, lines, square, star]
        images = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: images) as! [UIImage]
        
        // Loop over images, creating a CardViewController for each one and referencing wrt this ViewContoller
        for (index, position) in cardPositions.enumerated() {
            self.addCard(with: images[index], at: position, correctCard: star)
        }

        
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Generate particle effects
        self.createParticles()
        
        // Generate and load the Zener cards
        self.loadCards()
        
        // Animate background color of the view shifting between red and blue
        view.backgroundColor = .red
        UIView.animate(withDuration: 20, delay: 0, options: [.allowUserInteraction, .autoreverse, .repeat],
                       animations: {
                        self.view.backgroundColor = .blue
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

