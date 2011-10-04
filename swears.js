// TODO: encapsulate this in a thingie

Swears = {
  setIntervalId: 0,
  target: false,
  width: false,
  height: false,
  composite: false,
  layer_buffer: {},
  layers: [],
  layer_count: 0,
  
  add_layer: function() {
    Swears.layer_count++;
    layer = function() {
      this.x = 0;
      this.y = 0;
      this.data = Array(Array(false));
      this.key = Swears.layer_count;
    }
    
    var new_layer = new layer();
    Swears.layers.push(new_layer);
    Swears.layer_buffer[Swears.layer_count] = Swears.layers.length - 1;
    return new_layer;
  },
  
  remove_layer: function(layer) {
    Swears.layers.splice(Swears.layer_buffer[layer.key], 1);
    for(var i = Swears.layers.length - 1; i >= Swears.layer_buffer[layer.key]; i--) {
      Swears.layer_buffer[Swears.layers[i].key]--;
    }
    delete(Swears.layer_buffer[layer.key]);
    delete(layer);
  },
  
  layer_move_up: function(layer) {
    var index = Swears.layer_buffer[layer.key];
    if(index == Swears.layers.length - 1) {return false;}
    var next = Swears.layers[index + 1];
    Swears.layers[index] = next;
    Swears.layers[index + 1] = layer;
    Swears.layer_buffer[layer.key]++;
    Swears.layer_buffer[next.key]--;
  },
  
  layer_move_down: function(layer) {
    var index = Swears.layer_buffer[layer.key];
    if(index == 0) {return false;}
    var prev = Swears.layers[index - 1];
    Swears.layers[index] = prev;
    Swears.layers[index - 1] = layer;
    Swears.layer_buffer[layer.key]--;
    Swears.layer_buffer[prev.key]++;
  },
  
  // use a renderer to display stuff
  // TODO: allow renderer choice
  render: function() {
    Swears.renderers.pre();
  },
  
  // start the sequence
  play: function(framerate, target, width, height, callback) {
    Swears.target = target;
    Swears.width = width;
    Swears.height = height;
    
    if(!parseInt(framerate)) {return false;}
    var micros = parseInt(1000 / parseInt(framerate));
    micros = micros < 10 ? 10 : micros;
    Swears.setIntervalId = setInterval(function() {
      callback();
      Swears.render();
    }, micros);
  },
  
  // freeze time
  pause: function() {
    clearInterval(Swears.setIntervalId);
    delete(Swears.setIntervalId);
  },
  
  // TODO: move these outside and make it extensible
  renderers: {
    pre: function() {
      // pre-initialize composite array
      var composite = [];
      for(var y = 0; y < Swears.height; y++) {
        composite[y] = [];
        for(var x = 0; x < Swears.width; x++) {
          composite[y][x] = false;
        }
      }
      
      // composite layers
      for(var i = 0; i < Swears.layers.length; i++) {
        for(var y = Swears.layers[i].data.length - 1; y >= 0; y--) {
          for(var x = Swears.layers[i].data[y].length - 1; x >= 0; x--) {
            if(Swears.layers[i].data[y][x] !== false) {
              if(Swears.layers[i].invisible) {continue;}
              var true_y = y + Swears.layers[i].y;
              var true_x = x + Swears.layers[i].x;
              if(true_x < 0 || true_x >= Swears.width || true_y < 0 || true_y >= Swears.height) {continue;}
              composite[true_y][true_x] = Swears.layers[i].data[y][x];
            }
          }
        }
      }
      
      // composite -> string
      var string = '';
      for(var y = 0; y < Swears.height; y++) {
        for(var x = 0; x < Swears.width; x++) {
          string += composite[y][x] !== false ? composite[y][x] : ' ';
        }
        string += "\n";
      }
      
      // render in target
      Swears.target.innerHTML = string;
    }
  },
  
  // utility function for changing strings in matrices
  make_matrix: function(string) {
    var matrix = [];
    var lines = string.split(/\n/);
    for(var i=0; i < lines.length; i++) {
      var chars = [];
      for(var j=0; j < lines[i].length; j++) {
        chars.push(lines[i][j]);
      }
      matrix.push(chars);
    }
    
    return matrix;
  }
};
