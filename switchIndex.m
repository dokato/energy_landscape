function [swIdx] = switchIndex(switchvector)
%switchIndex returns a ratio of a number of switches

j_act = 0;
j_all = 0;
mmin = min(switchvector);
mmax = max(switchvector);
for is = 1:(length(switchvector)-1)
    if switchvector(is) == switchvector(is+1)
        continue
    end
    if switchvector(is+1) ~= mmin && switchvector(is+1) ~= mmax
        j_act = j_act + 1;
    end
    j_all = j_all + 1;
end

swIdx = j_act/j_all;

end

function test_switchIndex()
switchIndex([ 1 1 1 1 1 1 1 1 256]) == 0
switchIndex([ 1 1 1 1 1 1 1 1 256]) == 0
switchIndex([ 1 5 256]) == 0.5
end
