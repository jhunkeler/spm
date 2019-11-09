FROM centos:6
RUN yum install -y epel-release && yum clean -y all
RUN yum install -y \
	autoconf \
	automake \
	cmake \
	gcc \
	gcc-c++ \
	gcc-gfortran \
	help2man \
	libX11-devel \
	libxml2-devel \
	patchelf \
	perl \
	rsync \
	&& yum clean -y all
WORKDIR /build
COPY spm ./
COPY include ./include
RUN curl -L https://github.com/jhunkeler/reloc/archive/master.tar.gz | tar zxf - \
	&& cd reloc-* \
	&& mkdir -p build \
	&& cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
	&& make \
	&& make install \
	&& cd /build
