// void dispatch_read(dispatch_fd_t fd, size_t length,	dispatch_queue_t queue,	void *handler);

// void dispatch_write(dispatch_fd_t fd,	dispatch_data_t data,	dispatch_queue_t queue,	void *handler);

// void dispatch_io_read(dispatch_io_t channel, off_t offset, size_t length,	dispatch_queue_t queue,	dispatch_io_handler_t io_handler);

// void dispatch_io_write(dispatch_io_t channel,	off_t offset,	dispatch_data_t data,	dispatch_queue_t queue,	dispatch_io_handler_t io_handler);

// void dispatch_io_close(dispatch_io_t channel, dispatch_io_close_flags_t flags);

// void dispatch_io_barrier(dispatch_io_t channel, dispatch_block_t barrier);

// void dispatch_io_set_high_water(dispatch_io_t channel, size_t high_water);

// void dispatch_io_set_low_water(dispatch_io_t channel, size_t low_water);

// void dispatch_io_set_interval(dispatch_io_t channel, uint64_t interval,	dispatch_io_interval_flags_t flags);

void dispatch_async(dispatch_queue_t queue, dispatch_block_t block);

void _dispatch_call_block_and_release(void *a, void *b)?;
