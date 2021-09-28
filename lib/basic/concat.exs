defmodule Concat do

    def join(s1, s2 \\ nil, sep \\ " ")

    def join(s1, s2, _sep) when(is_nil(s2)) do
        s1
    end
    def join(s1, s2, _sep) do
        s1 <> sep <> s2
    end

end