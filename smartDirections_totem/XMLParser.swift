//
//  Data.swift
//  test1
//
//  Created by drosdesd on 28/03/2018.
//  Copyright © 2018 drosdesd. All rights reserved.
//

import UIKit
import Foundation

struct Place
{
    var placeId: String
    var name: String
    var location: String
}

class DestinationParser: NSObject, XMLParserDelegate
{
    private var places: [Place] = []
    private var currentElement = ""
    
    private var currentPlaceId: String = ""
    private var currentName: String = ""
    private var currentLocation: String = ""
    
    private var parserCompletionHandler: (([Place]) -> Void)?
    var pl_id: String = ""
    
    func parseFeed(url: String, completionHandler: (([Place]) -> Void)?)
    {
        self.parserCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request){ (data, response, error) in
            guard let data = data else{
                if let error = error{
                    print(error.localizedDescription)
                }
                return
            }
            
            //parse xml
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    //MARK: XML PARSE DELEGATE
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
        if currentElement == "place"{
            pl_id = attributeDict["placeid"]!
            currentName = ""
            currentLocation = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        switch currentElement {
        //case "place": currentPlaceId += attributeDict["placeid"] as Any
        case "name": currentName += String(string.filter{ !"\n\t\r".contains($0) })
        case "location": currentLocation += String(string.filter{ !"\n\t\r".contains($0) })
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "place" {
            let rssItem = Place(placeId: pl_id, name: currentName, location: currentLocation)
            self.places.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser)
    {
        parserCompletionHandler!(places)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        print(parseError.localizedDescription)
    }
}
