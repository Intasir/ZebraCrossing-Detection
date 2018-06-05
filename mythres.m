function threshold= mythres(image_sobel)
h=imhist(image_sobel);
display(sum(h));
w1=zeros(256,1);
w2=zeros(256,1);
m1=zeros(256,1);
m2=zeros(256,1);
v1=zeros(256,1);
v2=zeros(256,1);
cv=zeros(256,1);
for i=1:1:256
    s1=0;
    s2=0;
    for j=1:1:i
        s1=s1+h(j);
    end
    w1(i)=s1/sum(h);
    for k=i+1:1:256
        s2=s2+h(k);
    end
    w2(i)=s2/sum(h);
end
for i=1:1:256
    s1=0;
    s2=0;
    s3=0;
    s4=0;
    for j=1:1:i
        s1=s1+(j-1)*(h(j));
        s3=s3+h(j);
    end
    m1(i)=s1/s3;
    if(isnan(m1(i))==1)
        m1(i)=0;
     end
    for k=i+1:1:256
        s2=s2+(k-1)*(h(k));
        s4=s4+h(k);
    end
    m2(i)=s2/s4;
     if(isnan(m2(i))==1)
        m2(i)=0;
     end
end
for i=1:1:256
    s1=0;
    s2=0;
    s3=0;
    s4=0;
    for j=1:1:i
        s1=s1+((j-1)-m1(i))^2*(h(j));
        s3=s3+h(j);
    end
    v1(i)=s1/s3;
    if(isnan(v1(i))==1)
        v1(i)=0;
     end
    for k=i+1:1:256
        s2=s2+((k-1)-m2(i))^2*(h(k));
        s4=s4+h(k);
    end
    v2(i)=s2/s4;
    if(isnan(v2(i))==1)
        v2(i)=0;
     end
end
for i=1:1:256
    cv(i)=w1(i)*v1(i)+w2(i)*v2(i);
end
[value,index] = min(cv(:));
[row, col] = ind2sub(size(cv), index);
threshold=row/256;