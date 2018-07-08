//
//  IMGFilterCoordinatorInput.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation


protocol IMGFilterCoordinatorInput {
    
    /// Close the filter and pass the given parameters to filter caller
    ///
    /// - Parameter newParameters: new filtering criteria 
    func close(newParameters: IMGContent.Query?)
    
    
    /// Show list of given options to choose
    ///
    /// - Parameters:
    ///   - list: available options
    ///   - lastSelected: currently selected option index
    ///   - complete: is called when any option from the list is selected
    func showOptions(_ list: [String], lastSelected: Int?, complete: @escaping (Int) -> Void)
}
