function setup(block)
block.NumInputPorts = 1;
block.NumOutputPorts = 1;

block.InputPort(1).Dimensions = 1;
block.InputPort(1).DatatypeID = 0;
block.InputPort(1).Complexity = 'Real';
block.InputPort(1).DirectFeedthrough = true;
block.InputPort(1).SamplingMode = 'Sample';

block.OutputPort(1).Dimensions = 1;
block.OutputPort(1).DatatypeID = 0;
block.OutputPort(1).Complexity = 'Real';
block.OutputPort(1).SamplingMode = 'Sample';

block.NumContStates = 1;

block.NumDialogPrms = 2;

block.SampleTimes = [0 0];

block.RegBlockMethod('InitializeConditions', @InitializeConditions);
block.RegBlockMethod('Outputs', @Outputs);
block.RegBlockMethod('Derivatives', @Derivatives);
block.RegBlockMethod('Terminate', @Terminate);

end

function InitializeConditions(block)
block.ContStates.Data = 0;

end

function Derivatives(block)
L = block.DialogPrm(1).Data;
R = block.DialogPrm(2).Data;
i = block.ContStates.Data;
u = block.InputPort(1).Data;

i_d = (u - i * R)/L;

block.Derivatives.Data = i_d;

end

function Outputs(block)
i = block.ContStates.Data;
u = block.InputPort(1).Data;

p = u*i;

block.OutputPort(1).Data = p;
end

function Terminate(block)
%nothing to do so far
end