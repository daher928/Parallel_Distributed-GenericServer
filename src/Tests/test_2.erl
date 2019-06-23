-module(test_2).

-compile(export_all).

start()->   
    loadBalance:startServers().

stop()->
    loadBalance:stopServers().

status(Time)->
    io:format("~p:Server 1 is handlling ~p tasks ~n",[Time,loadBalance:numberOfRunningFunctions(1)]),
    io:format("~p:Server 2 is handlling ~p tasks ~n",[Time,loadBalance:numberOfRunningFunctions(2)]),
    io:format("~p:Server 3 is handlling ~p tasks ~n",[Time,loadBalance:numberOfRunningFunctions(3)]).

whereare()->
    io:format("Server 1 pid is: ~p t~n",[whereis(server1)]),
    io:format("Server 2 pid is: ~p t~n",[whereis(server2)]),
    io:format("Server 3 pid is: ~p t~n",[whereis(server3)]).

battle()->
    compile:file(loadBalance),compile:file(loadBalance_sup),compile:file(funServer), 
    F3 = fun()-> timer:sleep(3),3*3 end, 
    F5 = fun()-> timer:sleep(10000),4*4 end, 

    %Divide 10 functions: 
    whereare(),
    myLoop(F3,10),
    status(fastTest),
    myLoop(F5,100000),
    status(sec0),
    timer:sleep(1000),
    status(sec1),
    timer:sleep(1000),
    status(sec2),
    timer:sleep(1000),
    status(sec3),
    timer:sleep(1000),
    status(sec4),
    timer:sleep(1000),
    status(sec5),
    timer:sleep(1000),
    status(sec6),
    timer:sleep(1000),
    status(sec7),
    timer:sleep(1000),
    status(sec8),
    timer:sleep(1000),
    status(sec9),
    timer:sleep(1000),
    status(sec10_end_test),
    timer:sleep(1000),
    status(sec11),
    timer:sleep(1000),
    status(sec12),    
    ok.
                
myLoop(_F,0)->
    ok;

myLoop(F,Times)->
    loadBalance:calcFun(self(),F,make_ref()),
    myLoop(F,Times-1).



main()->
    start(),
    battle(),
    stop(),
    c:flush(),
    ok_main.


