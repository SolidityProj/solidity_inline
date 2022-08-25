操作码	标记	解释
stop	-	停止执行，相当于返回（0,0)
add(x,y)	 	x + y
sub(x,y)	 	x - y
mul(x,y)	 	x * y
div(x,y)	 	x / y
sdiv(x,y)	 	x / y ,对于有符号数，用补码
mod(x,y)	 	x % y
smod(x,y)	 	x % y,对于有符号数，用补码
exp(x,y)	 	x的y次方
not(x)	 	～x，按位取反
lt(x,y)	 	如果x < y,返回1，否则返回0
gt(x,y)	 	如果x > y,返回1，否则返回0
slt(x,y)	 	如果x < y,返回1，否则返回0,对于有符号数，用补码
sgt(x,y)	 	如果x > y,返回1，否则返回0,对于有符号数，用补码
eq(x,y)	 	如果x == y,返回1，否则返回0
iszero(x)	 	如果x == 0,返回1，否则返回0
and(x,y)	 	x和y按位与
or(x,y)	 	x和y按位或
xor(x,y)	 	x和y按位异或
byte(n,x)	 	x的第n位，最重要的是第0位
addmod(x,y,m)	 	(x + y) % m，可以是任意精度的算术
mulmod(x,y,m)	 	(x * y) % m，可以是任意精度的算术
signxtend(i,x)	 	从第（i * 8 + 7）位开始数最少签名位数，来扩展签名
keccak256(p,n)	 	keccak(mem[p...(p+n)))
sha3(p,n)	 	sha3(mem[p...(p+n)))
jump(label)	-	跳转到label标签／代码位置
jumpi(label, cond)	-	如果cond非零，就跳转到label标签
pc	 	代码的当前位置
pop(x)	-	删除x推入的元素
dup1 ... dup16	 	拷贝第i位的元素到栈顶（从顶端开始数）
swap1 ... swap16	*	交换栈顶和第i位的元素
mload（p）	 	mem[p..(p+32))
mstore(p, v)	-	mem[p..(p+32)) := v
mstore8(p, v)	-	mem[p] := v & 0xff - 只分配一个字节
sload(p)	 	storage[p]
sstore(p, v)	-	storage[p] := v
msize	 	内存的大小，例如最大的内存可访问索引
gas	 	可用的gas数
address	 	当前合约／执行上下文的地址
balance(a)	 	地址a的余额，单位为wei
caller	 	调用者（不包含delegatecall）
callvalue	 	当前调用发送的wei数
calldataload(p)	 	从位置p开始的调用数据（32位）
calldatasize	 	调用数据的大小，bytes为单位
calldatacopy(t,f,s)	-	从数据位置f，拷贝s位数据，到内存位置t
codesize	 	当前合约/执行上下文的代码大小
codecopy(t,f,s)	-	从代码位置f，拷贝s位数据，到内存位置t
extcodesize(a)	 	地址a处代码的大小
extcodecopy(a, t, f, s)	-	像codecopy(t,f,s)，但是是位置a处的代码
returndatasize	 	上个返回值的数据大小
returndatacopy(t, f, s)	-	在返回数据的位置f拷贝s位，到内存位置t
create(v, p, s)	 	用 mem[p..(p+s))长度的代码，创建一个新的合约，发送v wei的以太币，并返回合约地址
create2(v, n, p, s)	 	用 地址为keccak256(< address > . n . keccak256(mem[p..(p+s)))，mem[p..(p+s))长度的代码，创建一个新的合约，发送v wei的以太币，并返回合约地址
call(g, a, v, in, insize, out, outsize)	 	调用地址a上的合约，参数为mem[in..(in+insize))，提供g的gas，v wei的以太币，输出到mem[out..(out+outsize))，如果成功返回1，失败（例如gas不足）返回0
callcode(g, a, v, in, insize, out, outsize)	 	与call相同，但是使用a处的代码，并只能在当前合约的上下文中执行
delegatecall(g, a, in, insize, out, outsize)	 	与callcode相同，但是保留caller和callvalue
staticcall(g, a, in, insize, out, outsize)	 	与_call(g, a, 0, in, insize, out, outsize) _相同，但是不允许改变状态
return(p, s)	-	结束执行，返回数据mem[p..(p+s))
revert(p, s)	-	结束执行，恢复状态变化，返回数据mem[p..(p+s))
selfdestruct(a)	-	结束执行，销毁当前合约，并把余额发送给a地址
invalid	-	用invalid指令结束执行
log0(p,s)	-	记录日志，不包含主题，数据为mem[p..(p+s)
log1(p,s,t1)	-	记录日志，包含主题t1，数据为mem[p..(p+s)
log2(p,s,t1,t2)	-	记录日志，包含主题t1，t2，数据为mem[p..(p+s)
log3(p,s,t1,t2,t3)	-	记录日志，包含主题t1，t2，t3，数据为mem[p..(p+s)
log4(p,s,t1,t2,t3,t4)	-	记录日志，包含主题t1，t2，t3，t4，数据为mem[p..(p+s)
origin	 	交易发起方
gasprice	 	交易的gas价格
blockhash(b)	 	区块序列为b的hash - 只能获取到当前块的最近256块
coinbase	 	当前的矿工收益
timestamp	 	自创世纪区块以来的时间戳，单位为秒
number	 	当前区块的序号
difficulty	 	当前区块的难度
gaslimit	 	当前代码块的gas限制
