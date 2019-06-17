# Parallel_Distributed-GenericServer
Gen_server based parallel distributed server for function execution.
	- 3 parallel server with load balance

<h2>Compilation</h2>

$ c(servers_supervisor).
$ c(function_server).
$ c(loadBalance).

<h2>Start system</h2>
$ loadBalance:startServers().

<h2>Stop system</h2>
$ loadBalance:stopServers().
