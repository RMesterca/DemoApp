//
//  ReuseIdentifiers.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

//NOTE: -
/*
 I am not sure if the no storyboards limitation
 also excludes the use of xibs for the view or cells.
 Therefore, I will do everything programatically.

 If the use of xibs would be allowed, there would be
 a more elegant solution to this, where I would set
 the reuse identifiers for the cells in the xib file
 and then use the auto-generated value from R.swift to access it,
 which also makes it more safe in case someone decides to change it
 i.e. R.reuseIdentifier.photoCell.identifier

 👉 R.swift: https://github.com/mac-cain13/R.swift

*/

enum ReuseIdentifiers: String {
    case mainPhotoList
}
