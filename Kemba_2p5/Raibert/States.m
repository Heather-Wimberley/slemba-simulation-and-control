classdef States < Simulink.IntEnumType
    enumeration
        Rest(0)
        Loading(1)
        Stance(2)
        Unloading(3)
        Flight(4)
        Feedforward(5)
        Accelerate(6)
   end
end
