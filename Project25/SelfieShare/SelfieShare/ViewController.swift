//
//  ViewController.swift
//  SelfieShare
//
//  Created by Ben Hall on 11/04/2018.
//  Copyright © 2018 BeshBashBosh. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {

    // MARK: - Properties
    var images = [UIImage]() // Storage for images
    
    // MultipeerConnectivity properties
    var peerID: MCPeerID! // identifies each user uniquely in a session
    var mcSession: MCSession! // Manager class that handles all multipeer connectivity
    var mcAdvertiserAssistant: MCAdvertiserAssistant! // Used when creating session. Tells others we exist and handling invitations
    
    // MARK: - Custom Methods
    func startHosting(action: UIAlertAction) {
        // Set up the advertiser for the service
        // The service type is used so users of same app connect to each other.
        // It must be a 15 digit string uniquely identifying the service (only aA-zZ, numbers, hyphens)
        // Apple example is "companyname-appname"
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil,
                                                      session: mcSession)
        // Start the advertiser
        mcAdvertiserAssistant.start()
    }
    
    func joinSession(action: UIAlertAction) {
        // Create instance of the MCBrowserVC
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    // MARK: - Selector Methods
    // Grabs the image picker
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // This will prompt user to decide how they want to connect to peers over network
    @objc func showConnectionPrompt() {
        // present action sheet
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    // MARK: - CollectionView methods
    // Number of cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // Dequeuing cells
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        
        // Access the imageview within the cell
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }
    
    // MARK: - UIImagePicker delegate methods
    // Called when image picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the picked image
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        // Dismiss the picker
        dismiss(animated: true)
        
        // Add to images array
        images.insert(image, at: 0)
        
        // Reload collection view
        collectionView?.reloadData()
    }
    
    // MARK: - MCSession delegate methods
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        return
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        return
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        return
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        return
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        return
    }
    
    // MARK: - MCBrowserViewController delegate methods
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        return
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        return
    }
    
    // MARK: - VC methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Edit nav controller title
        title = "SelfieShare"
        
        // Add right bar button item showing camera item and links to selector method importPicture
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self,
                                                            action: #selector(importPicture))
        // Add left bar button item showing add button that links to selector showConnectionPrompt
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                           action: #selector(showConnectionPrompt))
        
        // Set up the multipeer connection
        // Set a peer id
        peerID = MCPeerID(displayName: UIDevice.current.name)
        // Set up the session
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        // Set delegate of session
        mcSession.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

