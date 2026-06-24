FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# تثبيت التحديثات وأدوات الشبكة والـ SSH فقط
RUN apt update -y && apt install -y \
    openssh-server \
    sudo \
    vim \
    net-tools \
    curl \
    wget \
    git \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# إعداد مجلد العمل (اختياري ولكنه يحافظ على نفس المسار السابق)
WORKDIR /root/pro

# إعدادات تشغيل سيرفر SSH والـ Root
RUN mkdir /var/run/sshd

# تغيير كلمة المرور الخاصة بالـ root (تأكد من تغييرها لاحقاً لأمان سيرفرك)
RUN echo "root:echo77" | chpasswd

# السماح بدخول الـ Root عبر SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# فتح المنفذ 22
EXPOSE 22

# تشغيل سيرفر SSH
CMD ["/usr/sbin/sshd", "-D"]
