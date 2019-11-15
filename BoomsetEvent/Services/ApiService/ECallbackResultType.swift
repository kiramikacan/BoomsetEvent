//
//  ECallbackResultType.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

public enum ECallbackResultType {
    case Success(Any?)
    case Failure(ApiErrorModel)
}
