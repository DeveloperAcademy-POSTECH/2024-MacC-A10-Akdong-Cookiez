//
//  BirdCharacterImageType.swift
//  AKCOO
//
//  Created by 박혜운 on 11/20/24.
//

import UIKit

enum BirdCharacterImageType {
  case foriegn
  case local
  case previous
  
  var buying: UIImage {
    switch self {
    case .foriegn:  return UIImage(resource: .greenbirdpointL)
    case .local:    return UIImage(resource: .redbirdpointL)
    case .previous: return UIImage(resource: .yellowbirdpointL)
    }
  }
  
  var notBuying: UIImage {
    switch self {
    case .foriegn:  return UIImage(resource: .greenbirdpointR)
    case .local:    return UIImage(resource: .redbirdpointR)
    case .previous: return UIImage(resource: .yellowbirdpointR)
    }
  }
  
  var basic: UIImage {
    switch self {
    case .foriegn:  return UIImage(resource: .greenbird)
    case .local:    return UIImage(resource: .redbird)
    case .previous: return UIImage(resource: .yellowbird)
    }
  }
  
  var wingL: UIImage {
    switch self {
    case .foriegn:  return UIImage(resource: .greenbirdwingL)
    case .local:    return UIImage(resource: .redbirdwingL)
    case .previous: return UIImage(resource: .yellowbirdwingL)
    }
  }
  
  var wingR: UIImage {
    switch self {
    case .foriegn:  return UIImage(resource: .greenbirdwingR)
    case .local:    return UIImage(resource: .redbirdwingR)
    case .previous: return UIImage(resource: .yellowbirdwingR)
    }
  }
}
