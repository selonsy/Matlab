function[x,n] = sinseq(ns,nf,A,w0,alpha)
% ns=���е���㣻nf=���е��յ㣻A=�������еķ���
% w0=�������е�Ƶ�ʣ�alpha=�������еĳ�ʼ��λ
% x=�������������У�n=�������е�λ����Ϣ
n = [ns:nf];
x = A * sin(w0 * n + alpha);
