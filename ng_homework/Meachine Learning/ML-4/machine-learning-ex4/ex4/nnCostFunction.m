function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


%Part1:
X=[ones(m,1),X];  %5000*401
z2=X*Theta1';    %5000*401 * 401 *25 = 5000*25
a2=sigmoid(z2);  %5000*25
a2_2=[ones(m,1),a2];   %5000*26
z3=a2_2*Theta2';    %5000*26 * 26*10=5000*10
h=a3=sigmoid(z3);          %5000*10  5000个数据集的预测结果[1,0,0,0,0,0,0,0,0,0]
c=[1:num_labels];
y=(y==c);
J_temp1=-1.*(y.*log(h)+(1-y).*log(1-h))/m;
J_temp2=sum(J_temp1');%10个点的cost相加
J=sum(J_temp2);%5000个数据集相加

%Part2:
Theta1_re=Theta1(:,2:size(Theta1,2));
Theta2_re=Theta2(:,2:size(Theta2,2));
re=sum(sum(Theta1_re.^2))+sum(sum(Theta2_re.^2));
J_re=J+lambda/(2*m)*re;
J=J_re;

%Part3: wrong
%j=1/2(h-y)^2 
%dj_dh=h-y; %5000*10
%dh_dz3=sigmoidGradient(z3); %5000*10
%temp=dj_dh.*dh_dz3; %5000*10
%dz3_dTheta2=a2_2; %5000*26
%Theta2_grad_temp=temp'*dz3_dTheta2; %10*5000 * 5000*26 =10*26 
%Theta2_grad=Theta2_grad_temp/m; %10*26

%Part3:
Delta2=0;
Delta1=0;
for i=1:m;
    delta3=((h-y)(i,:))';%10*1
    delta2=Theta2'*delta3.*sigmoidGradient([ones(1),z2(i,:)]');%26*10 * 10*1 =26*1
    Delta2=Delta2+delta3*a2_2(i,:);%10*1 * 1*26 =10*26
    Delta1=Delta1+delta2*X(i,:);%26*1 * 1*401=26*401
end;
Delta1=Delta1(2:size(Delta1,1),:);
Theta1_re=Theta1;
Theta1_re(:,1)=0;  	
Theta2_re=Theta2;
Theta2_re(:,1)=0;
Theta1_grad=Delta1/m+lambda/m*Theta1_re;
Theta2_grad=Delta2/m+lambda/m*Theta2_re;








% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
