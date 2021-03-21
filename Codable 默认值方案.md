# Codable 默认值方案

## 给单独字段设置默认值

* 直接使用包大人@DecodableDefault的方案

## 给整个class 或者 struct内部所有属性设置默认值

### 方案一（ValuedCodable）

* 原理：通过重写KeyedDecodingContainer的默认实现来设置默认值
* 使用方式：在需要的设置默认值的类文件中，`import ValuedCodable`，当前文件中的所有实现Codable的类和结构体都能自动设置默认值
* 缺点：使用方式极其不优雅，易读性差，import代码的位置不够引人注意，通常代码阅读者不会关注到是否引入了ValuedCodable库。
* https://github.com/ChaselAn/CodableDefaultValueDemo/tree/main/CodableDemo/ValuedCodable

### 方案二（DefaultDecoderProtocol）

* 原理：指定当KeyedDecodingContainer的Key是DefaultDecoderKey类型时，才会重写KeyedDecodingContainer的默认实现

* 使用方式：在需要的设置默认值的类或者结构体中，将CodingKeys遵守DefaultDecoderKey协议，就可自动设置默认值。

  ```swift
  struct TestModel: Codable {
      let nickname: String
      let age: Int
      let isMale: Bool
      let avatar: String?
      let isBoss: Bool?
  
      enum CodingKeys: String, CodingKey, DefaultDecoderKey {
          case nickname
          case age
          case isMale
          case avatar
          case isBoss
      }
  }
  ```

* 缺点：使用时必须将CodingKeys显示的编写出来并且遵守DefaultDecoderKey，不能享受到CodingKeys的默认实现带来的便捷

* https://github.com/ChaselAn/CodableDefaultValueDemo/tree/main/CodableDemo/DefaultDecoderProtocol

### 方案三（自定义实现JSONDecoder）

* 原理：仿照JSONDecoder的源码，实现一套自定义的JSONDecoder
* 已有现成的轮子，https://github.com/kemchenj/CustomJSONDecoder，可以基于现成轮子进行定制化改造。

