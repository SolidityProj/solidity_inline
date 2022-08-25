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
    
    
    
}
