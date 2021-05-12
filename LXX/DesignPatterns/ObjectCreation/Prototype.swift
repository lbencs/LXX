//
//  Prototype.swift
//  DesignPatterns
//
//  Created by lben on 2018/8/2.
//  Copyright © 2018 lben. All rights reserved.
//

import UIKit
/**
 定义：通过【复制】一个已经存在的实例来返回新的实例。
 used to create clones of a base object
 1. 设置一个原型
 2. 获取多个对象

 Object中的运用： 深拷贝、浅拷贝

 使用条件：
 1. 需要创建的对象独立于其类型与创建方式
 2. 要实例化的类型是在运行时决定的
 3. 复制相应数量的原型，比手工实例化更加方便。
 4. 类不容易创建，每个组件把其他组件作为直节点的组合对象。复制已有的组合对象并对副本进行修改更加容易。
 */

// 问题：Self vs Self.Type
protocol CloneAble {
    func clone() -> Self
}

protocol TextAble {
    var text: String { get set }
}

protocol ImageAble {
    var image: UIImage { get set }
}

protocol VideoAble {
    var vidioUrl: String { get set }
}

protocol MessageType {
    func clone() -> Self
}

extension MessageType {
    func clone() -> Self {
        fatalError("message")
    }
}

class Message: MessageType, CloneAble {
}

class TextMessage: Message, TextAble {
    var text: String = "Text"
    func clone() -> TextMessage {
        let message = TextMessage()
        message.text = text
        return message
    }
}

class VideoMessage: Message, VideoAble {
    var vidioUrl: String = "http://www.video.test.mp4"
    func clone() -> VideoMessage {
        let message = VideoMessage()
        message.vidioUrl = vidioUrl
        return message
    }
}

class ImageMessage: Message, ImageAble {
    var image: UIImage = UIImage()
    func clone() -> ImageMessage {
        let message = ImageMessage()
        message.image = image
        return message
    }
}
