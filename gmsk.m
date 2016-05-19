%GMSK 
%Generate bitstream 
bit_stream=randi([0 1],1,1000);
%pulse shape
%fs = 10^5
%fb =10^3
pulse_bit_stream=repmat(bit_stream,100,1);
pulse_bit_stream=reshape(pulse_bit_stream,1,[]);
pulse_bit_stream(pulse_bit_stream==0)=-1;
%2*sigma here corresponds to a bit period 
%sigma = 0.5*10^-3
sigma=0.5*10^-3;
time=-2*10^-3:10^-5:2*10^-3;
imp_gaussian=(1/(sqrt(2*pi)*sigma))*exp(-(time.^2/(2*(sigma^2))));
%imp_gaussian=imp_gaussian;%/max(imp_gaussian);
%plot(time,imp_gaussian);
%convolve both 
%screw time bandwidth product for now.Let's get the signal out first 
filtered_bit_stream=conv(pulse_bit_stream,imp_gaussian)*10^-5;

%generate the phasor 
fc=1000;
tim_start=10^-5;
phasor(1)=0;
tim_index=1;
fm=(1/(4*10^-3));
 for i=1:length(filtered_bit_stream)
    phasor(tim_index)=2*pi*fc*tim_start+(2*pi*fm*10^-5*sum(filtered_bit_stream(1:i)));
    tim_index=tim_index+1;
    tim_start=tim_start+10^-5;
 end 
carrier_sig=cos(phasor);

%%%%%%%%%%%%%MSK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sigma=0.5*10^-9;
time=-2*10^-3:10^-5:2*10^-3;
imp_gaussian=(1/(sqrt(2*pi)*sigma))*exp(-(time.^2/(2*(sigma^2))));
imp_gaussian=imp_gaussian/max(imp_gaussian);
%plot(time,imp_gaussian);
%convolve both 
%screw time bandwidth product for now.Let's get the signal out first 
filtered_bit_stream_msk=conv(pulse_bit_stream,imp_gaussian);

%generate the phasor 
fc=1000;
tim_start=10^-5;
phasor_msk(1)=0;
tim_index=1;
fm=(1/(4*10^-3));
 for i=1:length(filtered_bit_stream_msk)
    phasor_msk(tim_index)=2*pi*fc*tim_start+(2*pi*fm*10^-5*sum(filtered_bit_stream_msk(1:i)));
    tim_index=tim_index+1;
    tim_start=tim_start+10^-5;
 end 
carrier_sig_msk=cos(phasor_msk);

