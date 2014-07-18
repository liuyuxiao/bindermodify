#!/system/bin/sh
DPATH="/sys/kernel/debug/tracing"
LPATH="/sys/kernel/debug/binder"
DATE=$(date +%Y%m%d%H%M%S)
echo nop > $DPATH/current_tracer
echo > $DPATH/trace
echo > $DPATH/trace_pipe

# set function tracer
echo function_graph > $DPATH/current_tracer
echo *binder*> $DPATH/set_ftrace_filter
echo funcgraph-abstime > $DPATH/trace_options
ps -t > /sdcard/binder_ftrace_ref_$DATE.txt
# start the tracing
echo 1 > $DPATH/tracing_on

sleep $1

echo 0 > $DPATH/tracing_on
cat $DPATH/trace > /sdcard/binder_ftrace_$DATE.txt



