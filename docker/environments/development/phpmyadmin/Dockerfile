FROM phpmyadmin

#for sessions persistence
VOLUME /sessions

RUN echo '' >> /usr/local/etc/php/conf.d/z-php-phpmyadmin.ini \
  && echo '[PHP]' >> /usr/local/etc/php/conf.d/z-php-phpmyadmin.ini \
  && echo 'post_max_size = 3G' >> /usr/local/etc/php/conf.d/z-php-phpmyadmin.ini \
  && echo 'upload_max_filesize = 3G' >> /usr/local/etc/php/conf.d/z-php-phpmyadmin.ini \
  && echo 'session.gc_maxlifetime = 10800' >> /usr/local/etc/php/conf.d/z-php-phpmyadmin.ini \