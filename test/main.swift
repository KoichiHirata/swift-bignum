//
//  main.swift
//  bignum
//
//  Created by Dan Kogai on 2/2/16.
//  Copyright © 2016 Dan Kogai. All rights reserved.
//

let test = TAP()
// check inits
test.eq(BigInt(+42 as Int), +BigInt(42), "BigInt(+42 as Int) == +BigInt(42)")
test.eq(BigInt(-42 as Int), -BigInt(42), "BigInt(-42 as Int) == -BigInt(42)")
test.eq(9223372036854775807 as BigInt, BigInt(Int.max), "BigInt is integerLiteralConvertible")
test.eq("0xfedcba98765432100123456789ABCDEF" as BigInt,
    BigInt("fedcba98765432100123456789ABCDEF", base:16), "BigInt is stringLiteralConvertible")
// check signed operations
test.eq(+BigInt(2) + -BigInt(1), +BigInt(1), "+2 + -1 == +1")
test.eq(-BigInt(2) + +BigInt(1), -BigInt(1), "-2 + +1 == -1")
test.eq(+BigInt(2) - -BigInt(1), +BigInt(3), "+2 - -1 == +3")
test.eq(-BigInt(2) - +BigInt(1), -BigInt(3), "-2 + -1 == -3")
test.eq(+BigInt(1) * +BigInt(1), +BigInt(1), "+1 * +1 == +1")
test.eq(-BigInt(1) * +BigInt(1), -BigInt(1), "-1 * +1 == -1")
test.eq(+BigInt(1) * -BigInt(1), -BigInt(1), "+1 * -1 == -1")
test.eq(-BigInt(1) * -BigInt(1), +BigInt(1), "-1 * -1 == +1")
test.eq(+BigInt(3) / +BigInt(2), +BigInt(1), "+3 / +1 == +1")
test.eq(-BigInt(3) / +BigInt(2), -BigInt(1), "-3 / +1 == -1")
test.eq(+BigInt(3) / -BigInt(2), -BigInt(1), "+3 / -1 == -1")
test.eq(-BigInt(3) / -BigInt(2), +BigInt(1), "-3 / -1 == +1")
test.eq(+BigInt(3) % +BigInt(2), +BigInt(1), "+3 % +1 == +1")
test.eq(-BigInt(3) % +BigInt(2), -BigInt(1), "-3 % +1 == -1")
test.eq(+BigInt(3) % -BigInt(2), +BigInt(1), "+3 % -2 == +1")
test.eq(-BigInt(3) % -BigInt(2), -BigInt(1), "-3 % -2 == -1")
// protocol UnsignedInteger
extension UInt: _UnsignedInteger {}
extension BigUInt: _UnsignedInteger {}
func fact<T:_Integer>(n:T)->T {
    return n < 2 ? 1 : (2...n).reduce(1, combine:*)
}
let ufact20 = 2432902008176640000 as UInt
let ufact42 = BigUInt("3C1581D491B28F523C23ABDF35B689C908000000000", base:16)
test.eq(fact(20 as UInt),       ufact20, "20! as UInt    == \(ufact20)")
test.eq(fact(42 as BigUInt),    ufact42, "42! as BigUInt == \(ufact42)")
// protocol Integer
extension Int: _Integer {}
extension BigInt: _Integer {}
let sfact20 = 2432902008176640000 as Int
let sfact42 = BigInt("3C1581D491B28F523C23ABDF35B689C908000000000", base:16)
test.eq(fact(20 as Int),    sfact20, "20! as Int    == \(sfact20)")
test.eq(fact(42 as BigInt), sfact42, "42! as BigInt == \(sfact42)")
func fib<T:_Integer>(n:T)->T {
    return n < 2 ? n : (2...n).reduce((0, 1)){ p, _ in (p.1, p.0 + p.1) }.1
}
for i in 1...42 {
    let bi = BigInt(i)
    test.eq(fact(bi) / fact(bi - 1), bi,    "BigInt: \(bi)!/\(bi-1)! == \(bi)")
    if i > 20 { continue }
    test.eq(fact(i) / fact(i - 1),  i,      "Int:    \(bi)!/\(bi-1)! == \(bi)")
    let bbi = bi + 100
    test.eq(fib(bbi),fib(bbi-2)+fib(bbi-1), "BigInt: F\(bbi) == F\(bbi-2)+F\(bbi-1)")
}
test.done()
