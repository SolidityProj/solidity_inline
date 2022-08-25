pragma solidity ^0.4.20;

contract Inviter {
   function Var() public view{
        assembly {
            let x           
            x := 5
        }
   }
 
 
    function addSolidity(uint x, uint y) public pure returns (uint) {
        return x + y;
    }


    function show() public view returns(bytes32){
        return bytes4(keccak256('function at() public view'));
    }
 

    function param() view {
        assembly {
            let a := 0x123             // 16进制
            let b := 42                // 10进制
            let c := "hello world"     // 字符串
            }
    }

    function getShow1() view returns(bytes32){
            return keccak256(0x0, 0x20);
    }

 
    function addAssembly(uint x, uint y) public pure returns (uint) {
        assembly {
            // Add some code here
            let result := add(x, y)
            mstore(0x0, result)
            return(0x0, 32)
        }
    }

 //在Solidity汇编中访问变量
    function assembly_local_var_access() public view returns(uint){ 
        uint b = 5; 
        
        assembly {                // defined inside  an assembly block
            let x := add(2, 3) 
            let y := 10 
            b := add(x, y)
        } 
        
        assembly {               // defined outside an assembly block
            let x := add(2, 3)
            let y := mul(x, b)
        }

        return b;
    }

    //汇编中的循环

    //for
    function for_loop_solidity(uint n, uint value) public view returns(uint) {
         
        assembly {
                    
            for { let i := 0 } lt(i, n) { i := add(i, 1) } { 
                value := mul(2, value) 
            }
                
            mstore(0x0, value)
            return(0x0, 32)
                
        }

    }

    //while
    function for_loop_solidity() public view returns(uint) {
        assembly {
            let x := 0
            let i := 0
            for { } lt(i, 0x100) { } {     // 等价 while(i < 0x100)
                x := add(x, mload(i))
                i := add(i, 0x20)
            }

            mstore(0x0, x)
            return(0x0, 32)
        }
    }

    //if
    function if_loop_solidity() public view returns(uint) {
        uint x = 0;
        assembly {
                if slt(x, 0) {  x := sub(0, x) } 
            }
        }

    //switch语句
    /*
    switch语句在语法上有一些限制：
    分支列表不需要大括号，但是分支的代码块需要大括号；
    所有的分支条件值必须：
        1）具有相同的类型
        2）具有不同的值
    如果分支条件已经涵盖所有可能的值，那么不允许再出现default条件
    */
    function switch_loop_solidity() public view returns(uint[]) {
        uint x = 0;
        uint y = 0;
        assembly {
            switch calldataload(4)
            case 0 {
                y := 1
                x := calldataload(0x24)
            }
            default {
                y := 2
                x := calldataload(0x44)
            }
            // sstore(0, div(x, 2))
            // mstore(0x0, x)
            // return(0x0, 32)
        }

        uint[] z;
        z.push(x);
        z.push(y);
        return z;

    }
    

    //Solidity汇编的函数
    /*
         从栈顶提取参数
        将结果压入栈
        function my_assembly_function(param1, param2) -> my_result {
        
        // param2 - (4 * param1)
        my_result := sub(param2, mul(4, param1))
    
    }
    let some_value = my_assembly_function(4, 9)  // 4 - (9 * 4) = 32

    EVM 包含了 return 的内置操作代码。如果在汇编函数中编写了return 操作码，它将停止完全执行当前上下文（内部消息调用），而不仅仅是当前汇编函数。

    */
    function func_loop_solidity() public view returns(uint[]) {
        //function my_assembly_function(param1, param2) {  
        // assembly code here
        //像 Rust一样，返回值用-> 指定会返回一个值.
    

       uint y = 0;
       uint x = 0;
       assembly {
            function allocate(length) -> pos {
                pos := mload(0x40)
                mstore(0x40, add(pos, length))
            }
            let x := allocate(62)
            // mstore(0x0, x)
            // return(0x0, 32)
        }
        uint[] z;
        z.push(x);
        z.push(y);
        return z;


    }

    //退出函数
    //可以使用特殊语句退出当前函数。
    //leave 关键字可以放置在汇编函数体的任意位置，以停止其执行流并退出它。它的工作原理与空返回语句完全相同，有一个例外：函数将返回上次复制的变量给返回变量。
    //leave 关键字只能在函数内使用
    /*
    EVM 操作码可以分为以下几类：

    算数和比较操作
    位操作
    密码学计算，目前仅包含keccak256
    环境操作码，主要指与区块链相关的全局信息，例如：blockhash或coinbase
    存储、内存和栈操作
    交易与合约调用操作
    停机操作
    日志操作
    //https://docs.soliditylang.org/en/v0.6.2/yul.html#evm-dialect
    

    多个赋值
    如果调用一个函数反复多个值，可以将他们赋值给元组（tuple）

    前面我们已经可以在汇编中创建函数，这些函数可以返回多个值。
    使用汇编函数可以一次分配多个值。 请参阅代码段

    assembly {
            
      function f() -> a, b {}
      let c, d := f()
            
    }
    栈平衡（Stack balancing）
    函数式： 更容易了解哪个操作数（operand）作用于哪个操作码（opcode）。
    非函数式：更容易看到这些值最终在堆栈中的位置。
    
    mstore(0x80, add(mload(0x80), 3))          // Functional style
    3 0x80 mload add 0x80 mstore               // Non-Functional style
    */

}



