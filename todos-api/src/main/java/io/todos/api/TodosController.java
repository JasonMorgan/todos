package io.todos.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.HttpStatus;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.ResponseStatusException;

import java.util.*;

@RestController
public class TodosController {

    private static Logger LOG = LoggerFactory.getLogger(TodosController.class);

    @Value("${todos.api.limit:100}")
    long _limit;

    @Value("${cacheUrl:http://localhost:8888}")
    String _cacheUrl;

    @Value("${backendUrl:http://localhost:9090}")
    String _backendUrl;

    private RestTemplate restTemplate;

    @Autowired
    public TodosController(RestTemplateBuilder builder) {
        this.restTemplate = builder.build();
    }

    @GetMapping("/")
    public List<Todo> retrieve() {
        LOG.debug("Retreiving all Todos");
        try {
            Todo[] cached = restTemplate.getForEntity(_cacheUrl, Todo[].class).getBody();
            //if cache is empty, hydrate
            if(cached.length < 1) {
                LOG.debug("Cache empty, retrieving from backend service");
                Todo[] backendResp = restTemplate.getForEntity(_backendUrl, Todo[].class).getBody();
                if(backendResp.length > 0)    Arrays.stream(backendResp)
                        .forEach(e->restTemplate.postForObject(_cacheUrl, e, Todo.class));
                return Arrays.asList(backendResp);
            } else {
                //Return cached list
                return Arrays.asList(cached);
            }
        } catch (Exception ex) {
            LOG.debug("Backend not available");
            return new ArrayList<Todo>();
        }
        
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping("/")
    public Todo create(@RequestBody Todo todo) {
        throwIfOverLimit();

        LOG.debug("Creating TODO: " + todo);
        Todo obj = new Todo();
        if(ObjectUtils.isEmpty(todo.getId())) {
            obj.setId(UUID.randomUUID().toString());
        } else {
            obj.setId(todo.getTitle());
        }
        if(!ObjectUtils.isEmpty(todo.getTitle())) {
            obj.setTitle(todo.getTitle() + "!!!");
        }
        if(!ObjectUtils.isEmpty(todo.isComplete())) {
            obj.setComplete(todo.isComplete());
        }

        //Write to DB
        Todo saved = restTemplate.postForObject(_backendUrl, obj, Todo.class);
        LOG.debug("Created in Backend");

        //Invalidate/Add Cache
        Todo cached = restTemplate.postForObject(_cacheUrl, saved, Todo.class);
        LOG.debug("Created in Cache");
        return saved;
    }

    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/{id}")
    public Todo put(@PathVariable String id, @RequestBody Todo todo) {

        if(todo.getId() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "todos.id cannot be null on put");
        }
        if(todo.getId() != id) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "todos.id ${todo.id} and id $id are inconsistent");
        }

        Todo obj = new Todo();
        if(ObjectUtils.isEmpty(todo.getId())) {
            obj.setId(UUID.randomUUID().toString());
        } else {
            obj.setId(todo.getTitle());
        }
        if(!ObjectUtils.isEmpty(todo.getTitle())) {
            obj.setTitle(todo.getTitle());
        }
        if(!ObjectUtils.isEmpty(todo.isComplete())) {
            obj.setComplete(todo.isComplete());
        }

        //Write to DB
        Todo saved = restTemplate.postForObject(_backendUrl, obj, Todo.class);
        LOG.debug("Created in Backend");

        //Invalidate/Add Cache
        Todo cached = restTemplate.postForObject(_cacheUrl, saved, Todo.class);
        LOG.debug("Created in Cache");
        return saved;
    }

    @DeleteMapping("/")
    public void deleteAll() {
        LOG.debug("Removing all Todos");

        //Remove from DB
        restTemplate.delete(_backendUrl);
        //Remove from Cache
        restTemplate.delete(_cacheUrl);
    }

    @GetMapping("/{id}")
    public Todo retrieve(@PathVariable("id") String id) {
        LOG.debug("Retrieving Todo: " + id);
        //Check cache + DB
        Todo cached = restTemplate.getForEntity(_cacheUrl + "/" + id, Todo.class).getBody();
        if(cached != null) {
            LOG.debug("Found cached version");
            return cached;
        } else {
            LOG.debug("Not in cache, retrieving from backend");
            Todo source = restTemplate.getForEntity(_backendUrl + "/" + id, Todo.class).getBody();
            if(source != null) {
                LOG.debug("Found in backend");
                cached = restTemplate.postForObject(_cacheUrl, source, Todo.class);
                return source;
            }
        }

        throw new ResponseStatusException(HttpStatus.NOT_FOUND, "todo.id = " + id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable("id") String id){
        //Remove from DB
        restTemplate.delete(_backendUrl + "/" + id);

        //Remove from Cache
        restTemplate.delete(_cacheUrl + "/" + id);
    }

    @PatchMapping("/{id}")
    public Todo update(@PathVariable("id") String id, @RequestBody Todo todo) {
        if(todo.getId() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "todos.id cannot be null on put");
        }
        if(todo.getId() != id) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "todos.id ${todo.id} and id $id are inconsistent");
        }

        Todo obj = new Todo();
        if(ObjectUtils.isEmpty(todo.getId())) {
            obj.setId(UUID.randomUUID().toString());
        } else {
            obj.setId(todo.getTitle());
        }
        if(!ObjectUtils.isEmpty(todo.getTitle())) {
            obj.setTitle(todo.getTitle());
        }
        if(!ObjectUtils.isEmpty(todo.isComplete())) {
            obj.setComplete(todo.isComplete());
        }

        //Write to DB
        Todo saved = restTemplate.postForObject(_backendUrl, obj, Todo.class);
        LOG.debug("Created in Backend");

        //Invalidate/Add Cache
        Todo cached = restTemplate.postForObject(_cacheUrl, saved, Todo.class);
        LOG.debug("Created in Cache");
        return saved;
    }

    private void throwIfOverLimit() {
        Todo[] cached = restTemplate.getForEntity(_cacheUrl, Todo[].class).getBody();
        if(cached.length >= _limit) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "todos.api.limit=$limit, todos.size=$count");
        } else {
            return;
        }
    }

}
