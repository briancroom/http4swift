/*
 The MIT License (MIT)

 Copyright (c) 2015 Shun Takebayashi

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
*/

#if os(OSX)
    import Darwin
#elseif os(Linux)
    import Glibc
#endif

enum WriterError: ErrorType {
    case GenericError(error: Int32)
}

public class HTTPResponseWriter {

    let socket: Int32

    init(socket: Int32) {
        self.socket = socket
    }

    public func write(bytes: UnsafePointer<Int8>) throws {
        var rest = Int(strlen(bytes))
        while rest > 0 {
            let sent = send(socket, bytes, rest, 0)
            if sent < 0 {
                throw WriterError.GenericError(error: errno)
            }
            rest -= sent
        }
    }

}
